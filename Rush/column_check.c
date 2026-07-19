#include <unistd.h>
/*
** Validates a single column's visibility (Top and Bottom clues)
*/
int	check_col_visibility(int grid[4][4], int col, int top_clue, int bot_clue)
{
	int	visible;
	int	max_height;
	int	i;

	visible = 0;
	max_height = 0;
	i = -1;
	while (++i < 4)
	{
		if (grid[i][col] > max_height)
		{
			max_height = grid[i][col];
			visible++;
		}
	}
	if (top_clue != 0 && visible != top_clue)
		return (0);
	visible = 0;
	max_height = 0;
	i = 4;
	while (--i >= 0)
	{
		if (grid[i][col] > max_height)
		{
			max_height = grid[i][col];
			visible++;
		}
	}
	return (bot_clue == 0 || visible == bot_clue);
}

int	check_all_cols(int grid[4][4], int clues[16])
{
	int	col;

	col = 0;
	while (col < 4)
	{
		if (!check_col_visibility(grid, col, clues[col], clues[col + 4]))
			return (0);
		col++;
	}
	return (1);
}