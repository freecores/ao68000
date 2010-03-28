/*
 * Copyright 2010, Aleksander Osman, alfik@poczta.fm. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this list of
 *     conditions and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright notice, this list
 *     of conditions and the following disclaimer in the documentation and/or other materials
 *     provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package ao68000_tool;

import java.io.OutputStream;
import java.util.Vector;
import java.util.HashMap;
import java.util.HashSet;

class GenerateMicrocode {
    static void entry(boolean newline, String name) throws Exception {
        /*
         * if newline is true: end of last line
         * if name is "offset_" + label: branch label
         * if name is "label_" + label: label declaration
         */

        if(ParseParams.prefixes == null || labels == null || lines == null) throw new Exception("Entry validator not initialized.");

        // save last line
        if(newline == true && current_line != null && current_line.size() > 0) lines.add(current_line);
        // prepare a new line
        if(newline == true) current_line = new HashMap<String,String>();

        // save label location
        if(name.startsWith("label_")) {
            String label = name.substring(6);
            if(labels.containsKey(label)) throw new Exception("Double label declaration: " + label);
            labels.put(label, lines.size());
            return;
        }

        // get prefix
        String prefix = "PROCEDURE_";
        if(name.startsWith("offset_")) {
            String label = name.substring(7);
            name = "label_" + label;
        }
        else {
            prefix = null;
            for(String p : ParseParams.prefixes) {
                if(name.startsWith(p)) {
                    prefix = p;
                    break;
                }
            }
        }
        
        if(prefix == null) throw new Exception("Unknown prefix for name: " + name);

        // check for double prefix
        if(current_line.containsKey(prefix)) throw new Exception("Double prefix call: " + prefix);

        // extend current line
        current_line.put(prefix, name);
    }

    static void fill_bit_part(int array[], int start, int end, int value) throws Exception {
        while(start <= end) {
            int bit = value & 0x1;

            array[start] = bit;

            value >>= 1;
            start++;
        }
    }
    static void final_process(OutputStream out) throws Exception {
        if(ParseParams.prefixes == null || labels == null || lines == null) throw new Exception("Final validator not initialized.");
        // add last line
        if(current_line != null && current_line.size() > 0) lines.add(current_line);

        
        int i=0;
        // resolve labels
        for(HashMap<String,String> line : lines) {
            if(line.containsKey("PROCEDURE_")) {
                String value = line.get("PROCEDURE_");

                if(value.startsWith("label_")) {
                    String label = value.substring(6);

                    if(labels.containsKey(label) == false) throw new Exception("Unresolved label: " + label);
                    int label_value = labels.get(label);

                    int delta = label_value - i;

                    if(delta < 0 || delta > 15) throw new Exception("Label: " + label + " out of bounds: " + delta);
                    line.put("PROCEDURE_", "value_" + delta);
                }
            }
            i++;
        }

        // prepare output header
        int depth = 1;
        while(depth < lines.size()) depth *= 2;

        out.write(new String("DEPTH = " + depth + ";\n").getBytes());
        out.write(new String("WIDTH = " + bit_line.length + ";\n").getBytes());
        out.write(new String("ADDRESS_RADIX = DEC;\n").getBytes());
        out.write(new String("DATA_RADIX = BIN;\n").getBytes());
        out.write(new String("CONTENT\n").getBytes());
        out.write(new String("BEGIN\n").getBytes());
        
        i=0;
        HashSet<String> set = new HashSet<String>();
        Vector<String> bit_lines = new Vector<String>();
        // prepare final bit array
        for(HashMap<String,String> line : lines) {
            for(int j=0; j<bit_line.length; j++) bit_line[j] = 0;

            for(String prefix : ParseParams.prefixes) {
                if(line.containsKey(prefix)) {
                    String string_value = line.get(prefix);

                    int value = 0;
                    if(string_value.startsWith("value_")) {
                        value = Integer.parseInt(string_value.substring(6));
                    }
                    else {
                        if(ParseParams.name_values.containsKey(string_value) == false) throw new Exception("Unknown value: " + string_value);
                        value = ParseParams.name_values.get(string_value);
                    }
                    int start = ParseParams.prefix_locations.get(prefix + "start");
                    int end = ParseParams.prefix_locations.get(prefix + "end");

                    fill_bit_part(bit_line, start, end, value);
                }
            }

            // prepare output
            String addr = "" + i + ": ";
            while(addr.length() < 8) addr = " " + addr;
            out.write(new String(addr).getBytes());

            String bits = "";
            for(int j=bit_line.length-1; j>=0; j--) {
                bits += bit_line[j];
            }
            set.add(bits);
            bit_lines.add(bits);
            out.write(new String(bits + ";\n").getBytes());

            i++;
        }
        out.write(new String("END;\n").getBytes());


        // prepare a compact microcode with a microcode decoder
        // microcode reduced to 500x8 bits = 4000 bits, but microcode decoder takes about 1000 LE
        // so currently unused
/*
        i = set.size();
        int bit_size = 0;
        while(i > 0) {
            bit_size++;
            i /= 2;
        }
        System.out.println("Set size: " + set.size() + ", bit size: " + bit_size + ", bit_line.length: " + bit_line.length);

        String empty_line = "";
        i = 0;
        while(i < bit_line.length) {
            empty_line += "0";
            i++;
        }


        String verilog = "assign micro_data =" + "\n";

        verilog += "(encoded == " + bit_size + "'d" + 0 + ") ? " + bit_line.length + "'b" + empty_line + " :" + "\n";
        HashMap<String, Integer> bit_line_numbers = new HashMap<String, Integer>();
        i = 1;
        for(String line : set) {
            verilog += "(encoded == " + bit_size + "'d" + i + ") ? " + bit_line.length + "'b" + line + " :" + "\n";

            bit_line_numbers.put(line, i);
            i++;
        }
        verilog += bit_line.length + "'b" + empty_line + ";" + "\n";

        i=0;
        for(String line : bit_lines) {
            String addr = "" + i + ": ";
            while(addr.length() < 8) addr = " " + addr;
            System.out.print(addr);

            String content = "" + bit_line_numbers.get(line) + ";";
            System.out.println(content);

            i++;
        }
        System.out.println("Verilog:\n" + verilog);
*/
    }
    static void print_microcode_defines(OutputStream out) throws Exception {
        if(ParseParams.prefix_locations == null || ParseParams.prefixes == null) throw new Exception("No prefix_locations or prefixes set.");

        out.write(new String("/*! \\file microcode_locations.v\n * \\brief Definitions of microcode locations.\n */\n").getBytes());

        for(String s : ParseParams.prefixes) {
            int start = ParseParams.prefix_locations.get(s + "start");
            int end = ParseParams.prefix_locations.get(s + "end");

            String short_name = s.substring(0, s.length()-1);
            short_name = short_name.toLowerCase();

            out.write(new String("`define MICRO_DATA_" + short_name + " " + "micro_data[" + end + ":" + start + "]\n").getBytes());
        }
        out.write(new String("\n").getBytes());
        
        for(String label : labels.keySet()) {
            if(label.startsWith("MICROPC_")) {
                out.write(new String("`define " + label + " 9'd" + labels.get(label) + "\n").getBytes());
            }
        }
    }
    static void generate(OutputStream microcode_os, OutputStream locations_os) throws Exception {
        bit_line = new int[ParseParams.control_bit_offset];
        lines = new Vector<HashMap<String,String>>();
        labels = new HashMap<String,Integer>();

        Microcode.microcode(new Parser());

        final_process(microcode_os);
        print_microcode_defines(locations_os);
    }
    static HashMap<String, String> current_line;
    static Vector<HashMap<String, String>> lines;
    static HashMap<String, Integer> labels;
    static int bit_line[];
}
