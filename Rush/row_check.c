#include <unistd.h>
/*
** Validates a single row's visibility (Left and Right clues)
*/
int	check_row_visibility(int grid[4][4], int row, int left_clue, int right_clue)
{
	int	visible;
	int	max_height;
	int	i;

	visible = 0;
	max_height = 0;
	i = -1;
	while (++i < 4)
	{
		if (grid[row][i] > max_height)
		{
			max_height = grid[row][i];
			visible++;
		}
	}
	if (left_clue != 0 && visible != left_clue)
		return (0);
	visible = 0;
	max_height = 0;
	i = 4;
	while (--i >= 0)
	{
		if (grid[row][i] > max_height)
		{
			max_height = grid[row][i];
			visible++;
		}
	}
	return (right_clue == 0 || visible == right_clue);
}