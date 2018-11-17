/// @func dia_gen_parser(dialogue_data, section)
/// @desc Processes a dialogue text file.
/// @arg  {string} dialogue_data The file data in an array.
/// @arg  {real} section The dialogue section to parse.

// Do not copy assignment0 to var to prevent copying massive arrays.
var sect = argument1;
var i = 0; // dia 'x' counter
var j = 0; // dia 'y' counter, where needed
var p = 0; // arg0 array pointer
var dia;

// [x,y]
// x, height = Line #.
// y, length = See constants script.

// Select the indicated section.
if (sect == "") // If no section is given, close the program.
{
	return "";
}

while (!string_pos(sect, argument0[p]))
{
	p++;
	if (p > array_length_1d(argument0))
		show_error("Section '" + sect + "' not found!", 1);
}

p += 2; // Point to first actual line.

// Transcribe each line to the dia array.
while (!string_pos(tx_sect_brk, argument0[p]) && p < array_length_1d(argument0))
{
	j = tx_lst; // Reinitialize the list counter for a line.
	dia[i, tx_dia] = argument0[p];
	p++;
	dia[i, tx_col] = argument0[p];
	p++;
	while (argument0[p] != "" && p < array_length_1d(argument0))
	{
		if (string_pos("#", argument0[p]) > 0)
		{
			dia[i, tx_eff] = argument0[p];
			p++;
			continue;
		}
		else
		{
			dia[i, j] = argument0[p];
			j++; p++;
		}
	}
	// Insert new meta tags above this line, remembering to adjust the pointer.
	i++; p++;
}

// Insert line breaks.
for (i = 0; i < array_height_2d(dia); i++)
{
	if (string_length(dia[i,0]) > tx_max_len)
	{
		var k = 0; // Character pointer for the string.
		for (j = 1; j < floor(string_length(dia[i, tx_dia]) / tx_max_len) + 1; j++)
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
			dia[i, tx_col] = 0xFFCC33; // Light blue.
			break;
		case "#purple":
			dia[i, tx_col] = c_purple;
			break;
		default:
			show_error("Not a color! '" + dia[i, tx_col] + "'", true);
	}
}

return dia;