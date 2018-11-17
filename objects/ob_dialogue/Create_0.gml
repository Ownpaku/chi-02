tx_key_count = 0; // Key press counter for advancing dialogues.
tx_lns_count = 0; // Counter for lines to show.
show_message(string(string_height("A")) + " " + string(string_width("A")));
words = dia_gen_parser(tx_file_loader("text_script.txt"), get_string("Section?", ""));
if words = ""
{
	game_end();
	exit;
}