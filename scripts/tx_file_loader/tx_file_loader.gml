/// @func tx_file_loader
/// @desc Load a text file into memory. Returns an array with data from file.
/// @arg  {string} file_name File to load.

var file = file_text_open_read(argument0);
var data;

if !file
	show_error("File not found!", 1);

for (var i = 0; !file_text_eof(file); i++)
{
	data[i] = file_text_read_string(file);
	file_text_readln(file);
}

file_text_close(file);

return data;