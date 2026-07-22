#!/usr/bin/env bash

# ==============================================================================
#                      42 MOULINETTE TESTER - C 05
# ==============================================================================

# --- Colors ---
RED='\030[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'
BOLD='\033[1m'

# --- Counter Tracking ---
TOTAL_EX=9
PASSED_EX=0

# Clean temporary test directory on exit
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo -e "${CYAN}${BOLD}=====================================================${RESET}"
echo -e "${CYAN}${BOLD}           42 C PISCINE - C 05 TESTER               ${RESET}"
echo -e "${CYAN}${BOLD}=====================================================${RESET}\n"

# Helper: Print Header
print_header() {
    echo -e "${YELLOW}${BOLD}---> [$1] Testing $2${RESET}"
}

# Helper: Norminette Check
check_norm() {
    local file=$1
    if command -v norminette &> /dev/null; then
        NORM_OUT=$(norminette -R CheckForbiddenSourceHeader "$file" 2>&1)
        if echo "$NORM_OUT" | grep -E -q "Error|INVALID"; then
            echo -e "  ${RED}[NORM ERROR]${RESET}"
            echo "$NORM_OUT" | grep -v "OK!" | sed 's/^/    /'
            return 1
        else
            echo -e "  ${GREEN}[NORM OK]${RESET}"
            return 0
        fi
    else
        echo -e "  ${YELLOW}[NORM SKIPPED] (norminette not installed)${RESET}"
        return 0
    fi
}

# ------------------------------------------------------------------------------
# EX00: ft_iterative_factorial
# ------------------------------------------------------------------------------
test_ex00() {
    print_header "ex00" "ft_iterative_factorial"
    local dir="ex00"
    local file="ft_iterative_factorial.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main00.c"
#include <stdio.h>
int ft_iterative_factorial(int nb);

int main(void) {
    printf("%d\n", ft_iterative_factorial(-5));  // Exp: 0
    printf("%d\n", ft_iterative_factorial(0));   // Exp: 1
    printf("%d\n", ft_iterative_factorial(1));   // Exp: 1
    printf("%d\n", ft_iterative_factorial(5));   // Exp: 120
    printf("%d\n", ft_iterative_factorial(10));  // Exp: 3628800
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main00.c" -o "$TMP_DIR/ex00_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex00_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
1
1
120
3628800
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX01: ft_recursive_factorial
# ------------------------------------------------------------------------------
test_ex01() {
    print_header "ex01" "ft_recursive_factorial"
    local dir="ex01"
    local file="ft_recursive_factorial.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main01.c"
#include <stdio.h>
int ft_recursive_factorial(int nb);

int main(void) {
    printf("%d\n", ft_recursive_factorial(-2));  // Exp: 0
    printf("%d\n", ft_recursive_factorial(0));   // Exp: 1
    printf("%d\n", ft_recursive_factorial(1));   // Exp: 1
    printf("%d\n", ft_recursive_factorial(5));   // Exp: 120
    printf("%d\n", ft_recursive_factorial(10));  // Exp: 3628800
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main01.c" -o "$TMP_DIR/ex01_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex01_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
1
1
120
3628800
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX02: ft_iterative_power
# ------------------------------------------------------------------------------
test_ex02() {
    print_header "ex02" "ft_iterative_power"
    local dir="ex02"
    local file="ft_iterative_power.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main02.c"
#include <stdio.h>
int ft_iterative_power(int nb, int power);

int main(void) {
    printf("%d\n", ft_iterative_power(2, -1)); // Exp: 0
    printf("%d\n", ft_iterative_power(0, 0));  // Exp: 1
    printf("%d\n", ft_iterative_power(5, 0));  // Exp: 1
    printf("%d\n", ft_iterative_power(2, 4));  // Exp: 16
    printf("%d\n", ft_iterative_power(-3, 3)); // Exp: -27
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main02.c" -o "$TMP_DIR/ex02_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex02_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
1
1
16
-27
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX03: ft_recursive_power
# ------------------------------------------------------------------------------
test_ex03() {
    print_header "ex03" "ft_recursive_power"
    local dir="ex03"
    local file="ft_recursive_power.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main03.c"
#include <stdio.h>
int ft_recursive_power(int nb, int power);

int main(void) {
    printf("%d\n", ft_recursive_power(2, -1)); // Exp: 0
    printf("%d\n", ft_recursive_power(0, 0));  // Exp: 1
    printf("%d\n", ft_recursive_power(5, 0));  // Exp: 1
    printf("%d\n", ft_recursive_power(2, 4));  // Exp: 16
    printf("%d\n", ft_recursive_power(-3, 3)); // Exp: -27
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main03.c" -o "$TMP_DIR/ex03_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex03_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
1
1
16
-27
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX04: ft_fibonacci
# ------------------------------------------------------------------------------
test_ex04() {
    print_header "ex04" "ft_fibonacci"
    local dir="ex04"
    local file="ft_fibonacci.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main04.c"
#include <stdio.h>
int ft_fibonacci(int index);

int main(void) {
    printf("%d\n", ft_fibonacci(-2)); // Exp: -1
    printf("%d\n", ft_fibonacci(0));  // Exp: 0
    printf("%d\n", ft_fibonacci(1));  // Exp: 1
    printf("%d\n", ft_fibonacci(3));  // Exp: 2
    printf("%d\n", ft_fibonacci(6));  // Exp: 8
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main04.c" -o "$TMP_DIR/ex04_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex04_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
-1
0
1
2
8
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX05: ft_sqrt
# ------------------------------------------------------------------------------
test_ex05() {
    print_header "ex05" "ft_sqrt"
    local dir="ex05"
    local file="ft_sqrt.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main05.c"
#include <stdio.h>
int ft_sqrt(int nb);

int main(void) {
    printf("%d\n", ft_sqrt(-5));     // Exp: 0
    printf("%d\n", ft_sqrt(0));      // Exp: 0
    printf("%d\n", ft_sqrt(1));      // Exp: 1
    printf("%d\n", ft_sqrt(4));      // Exp: 2
    printf("%d\n", ft_sqrt(5));      // Exp: 0
    printf("%d\n", ft_sqrt(25));     // Exp: 5
    printf("%d\n", ft_sqrt(2147395600)); // Exp: 46340
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main05.c" -o "$TMP_DIR/ex05_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex05_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
0
1
2
0
5
46340
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX06: ft_is_prime
# ------------------------------------------------------------------------------
test_ex06() {
    print_header "ex06" "ft_is_prime"
    local dir="ex06"
    local file="ft_is_prime.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main06.c"
#include <stdio.h>
int ft_is_prime(int nb);

int main(void) {
    printf("%d\n", ft_is_prime(-7)); // Exp: 0
    printf("%d\n", ft_is_prime(0));  // Exp: 0
    printf("%d\n", ft_is_prime(1));  // Exp: 0
    printf("%d\n", ft_is_prime(2));  // Exp: 1
    printf("%d\n", ft_is_prime(3));  // Exp: 1
    printf("%d\n", ft_is_prime(4));  // Exp: 0
    printf("%d\n", ft_is_prime(2147483647)); // Exp: 1
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main06.c" -o "$TMP_DIR/ex06_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex06_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
0
0
0
1
1
0
1
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX07: ft_find_next_prime
# ------------------------------------------------------------------------------
test_ex07() {
    print_header "ex07" "ft_find_next_prime"
    local dir="ex07"
    local file="ft_find_next_prime.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main07.c"
#include <stdio.h>
int ft_find_next_prime(int nb);

int main(void) {
    printf("%d\n", ft_find_next_prime(-10)); // Exp: 2
    printf("%d\n", ft_find_next_prime(2));   // Exp: 2
    printf("%d\n", ft_find_next_prime(14));  // Exp: 17
    printf("%d\n", ft_find_next_prime(20));  // Exp: 23
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main07.c" -o "$TMP_DIR/ex07_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex07_test" > "$TMP_DIR/out.txt"
    cat << 'EOF' > "$TMP_DIR/exp.txt"
2
2
17
23
EOF

    if diff -u "$TMP_DIR/out.txt" "$TMP_DIR/exp.txt" > /dev/null; then
        echo -e "  ${GREEN}[SUCCESS] All outputs matched expected values.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Output mismatch:${RESET}"
        diff -u "$TMP_DIR/exp.txt" "$TMP_DIR/out.txt" | sed 's/^/    /'
        echo ""
    fi
}

# ------------------------------------------------------------------------------
# EX08: The Ten Queens
# ------------------------------------------------------------------------------
test_ex08() {
    print_header "ex08" "ft_ten_queens_puzzle"
    local dir="ex08"
    local file="ft_ten_queens_puzzle.c"

    if [ ! -f "$dir/$file" ]; then
        echo -e "  ${RED}[FAIL] File $dir/$file missing.${RESET}\n"; return
    fi
    check_norm "$dir/$file" || NORM_FAIL=1

    cat << 'EOF' > "$TMP_DIR/main08.c"
#include <stdio.h>
int ft_ten_queens_puzzle(void);

int main(void) {
    int res = ft_ten_queens_puzzle();
    printf("TOTAL: %d\n", res);
    return 0;
}
EOF

    cc -Wall -Wextra -Werror "$dir/$file" "$TMP_DIR/main08.c" -o "$TMP_DIR/ex08_test" 2>"$TMP_DIR/err.log"
    if [ $? -ne 0 ]; then
        echo -e "  ${RED}[COMPILATION ERROR]${RESET}"
        cat "$TMP_DIR/err.log" | sed 's/^/    /'
        echo ""; return
    fi

    "$TMP_DIR/ex08_test" > "$TMP_DIR/out.txt"

    # Verify return value (Total = 724 solutions)
    local count=$(wc -l < "$TMP_DIR/out.txt")
    local total_line=$(tail -n 1 "$TMP_DIR/out.txt")

    if [ "$total_line" == "TOTAL: 724" ] && [ "$count" -eq 725 ]; then
        echo -e "  ${GREEN}[SUCCESS] Displayed 724 solutions and returned 724 correctly.${RESET}\n"
        ((PASSED_EX++))
    else
        echo -e "  ${RED}[FAIL] Expected 724 solutions with return value 724.${RESET}"
        echo -e "  Got line count: $((count-1))"
        echo -e "  Got return summary: $total_line"
        echo ""
    fi
}

# --- Execution ---
test_ex00
test_ex01
test_ex02
test_ex03
test_ex04
test_ex05
test_ex06
test_ex07
test_ex08

# --- Summary ---
echo -e "${CYAN}${BOLD}=====================================================${RESET}"
echo -e "${BOLD}FINAL SCORE: $PASSED_EX / $TOTAL_EX Exercises Passed${RESET}"
echo -e "${CYAN}${BOLD}=====================================================${RESET}"
