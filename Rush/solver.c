#include <unistd.h>

/*
** Checks if 'num' already exists in the current row or column
*/
int	is_safe(int grid[4][4], int row, int col, int num)
{
	int	i;

	i = 0;
	while (i < 4)
	{
		if (grid[row][i] == num || grid[i][col] == num)
			return (0);
		i++;
	}
	return (1);
}
/*
** Backtracking solver function
*/
int	solve(int grid[4][4], int clues[16], int index)
{
	int	row;
	int	col;
	int	num;

	if (index == 16)
		return (check_all_cols(grid, clues));
	row = index / 4;
	col = index % 4;
	num = 1;
	while (num <= 4)
	{
		if (is_safe(grid, row, col, num))
		{
			grid[row][col] = num;
			if (col == 3 && !check_row_visibility(grid, row,
					clues[row + 8], clues[row + 12]))
			{
				grid[row][col] = 0;
				num++;
				continue ;
			}
			if (solve(grid, clues, index + 1))
				return (1);
			grid[row][col] = 0;
		}
		num++;
	}
	return (0);
}