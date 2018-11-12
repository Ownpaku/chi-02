tx_key_count = 0; // Key press counter for advancing dialogues.
tx_lns_count = 0; // Counter for lines to show.

var file = file_text_open_read(working_directory + "text_script.txt");

if !file
	show_error("File not found!", 1);

words = parser(file, get_string("Section?", ""));
file_text_close(file);