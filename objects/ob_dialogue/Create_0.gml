tx_key_count = 0; // Key press counter for advancing dialogues.
tx_lns_count = 0; // Counter for lines to show.

words = tx_file_loader("text_script.txt");
words = parser(words, get_string("Section?", ""));