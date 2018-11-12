var j = array_height_2d(words);
var yy = y;
var cont = false;

for (var i = tx_lns_count; i <= tx_key_count && i < j; i++)
{
	cont = false;
	if array_length_2d(words, i) > 3
	{
		switch words[i, 3]
		{
			case "#clear": // Set next draw to start from this line.
				tx_lns_count = i;
				words[i, 3] = "";
				var cont = true;
				break;
		}
	}
	if cont
		continue;
	draw_text_colour(x, yy, words[i, tx_dia], words[i, tx_col], words[i, tx_col], words[i, tx_col], words[i, tx_col], 1);
	yy = yy + (words[i, tx_lns] * 21) + tx_ln_space;
}