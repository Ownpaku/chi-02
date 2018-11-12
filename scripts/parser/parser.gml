/// @func parser(dialogue_file, section)
/// @desc Processes a dialogue text file.
/// @arg  {real} dialogue_file The file ID of the dialogue file.
/// @arg  {real} section The dialogue section to parse.

var file = argument0;
var sect = argument1;
var ln_chk; // Line checker.
var i;
var dia;

// [x,y]
// x / height = Line #.
// y / length = See constants script.

// Select the indicated section.
ln_chk = file_text_read_string(file);
while (string_pos(sect, ln_chk) = 0)
{
	if file_text_eof(file)
		show_error("Section '" + sect + "' not found!", 1);
	file_text_readln(file);
	ln_chk = file_text_read_string(file);
}
file_text_readln(file);
file_text_readln(file);

// Transcribe each line to an array.
ln_chk = file_text_read_string(file);
i = 0;
while (string_pos(tx_sect_brk, ln_chk) = 0 && !file_text_eof(file))
{
	dia[i, tx_dia] = ln_chk; // Dialogue.
	file_text_readln(file);
	dia[i, tx_col] = file_text_read_string(file); // Color tag.
	file_text_readln(file);
	ln_chk = file_text_read_string(file);
	if ln_chk != ""
	{
		dia[i, tx_eff] = ln_chk; // Effect tag.
		file_text_readln(file);
	}
	// Insert new meta tags above this line, remembering to go to the new line.
	i++;
	file_text_readln(file);
	ln_chk = file_text_read_string(file);
}

// Insert line breaks.
for (i = 0; i < array_height_2d(dia); i++)
{
	if string_length(dia[i,0]) > tx_max_len 
	{
		var k = 0; // Character pointer for the string.
		for (var j = 1; j < floor(string_length(dia[i, tx_dia]) / tx_max_len) + 1; j++)
		{
			
			k = k + tx_max_len;
			while string_char_at(dia[i, tx_dia], k) != " " 
				k--;
			dia[i, tx_dia] = string_insert("\n", dia[i, tx_dia], k);
			dia[i, tx_dia] = string_delete(dia[i, tx_dia], k + 1, 1);
		}
		dia[i, tx_lns] = string_count("\n", dia[i, tx_dia]) + 1;
	}	
	else
		dia[i, tx_lns] = 1;
}	

// Replace color tags with GML colors.
for (i = 0; i < array_height_2d(dia); i++)
{
	switch (dia[i, tx_col])
	{
		case "##":
		case "#black":
			dia[i, tx_col] = c_black;
			break;
		case "#white":
			dia[i, tx_col] = c_white;
			break;
		case "#red":
			dia[i, tx_col] = c_red;
			break;
		case "#orange":
			dia[i, tx_col] = c_orange;
			break;
		case "#yellow":
			dia[i, tx_col] = c_yellow;
			break;
		case "#green":
			dia[i, tx_col] = c_lime;
			break;
		case "#blue":
			dia[i, tx_col] = 16763955; // Light blue.
			break;
		case "#purple":
			dia[i, tx_col] = c_purple;
			break;
		default:
			show_error("Not a color! '" + dia[i, tx_col] + "'", true);
	}
}

return dia;