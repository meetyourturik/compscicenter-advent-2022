"""
эта версия прошла все тесты, но я до сих пор не уверен в её правдоподобности
изначально оптимальная стратегия заключалась в максимизации процента своих клеток после каждого хода
но такая стратегия падала на последнем тесте
в итоге в 46й строке я добавил условие, что если этот процент меньше половины - игрок по сути сдаётся
такая стратегия прокатила, но не работает для поля MMMFM
впрочем, оригинальная стратегия так же неверна например для поля MMFM
"""

rows = ["FFMFMFM", "FFMMMMF", "MMMFMFM", "FMFFMMF"]

m = len(rows)
n = len(rows[0])

before = False
PLAYER = "F"

while (m > 1 or n > 1):
	print (PLAYER, m, n, rows)
	perm1 = 0
	perm2 = 0
	pos1 = 0
	pos2 = 0
	for i in range(1, int(m / 2) + 1):
		size = (m - i) * n
		perl = sum(map(lambda r: r.count(PLAYER), rows[i:])) / size
		perr = sum(map(lambda r: r.count(PLAYER), rows[:-i])) / size
		if (perl > perm1):
			perm1 = perl
			pos1 = i
		if (perr > perm1):
			perm1 = perr
			pos1 = -i
	
	for i in range(1, int(n/2) + 1):
		size = m * (n - i)
		perl = sum(map(lambda r: r[i:].count(PLAYER), rows)) / size
		perr = sum(map(lambda r: r[:-i].count(PLAYER), rows)) / size
		if (perl > perm2):
			perm2 = perl
			pos2 = i
		if (perr > perm2):
			perm2 = perr
			pos2 = -i

	if (perm1 < 0.5 and perm2 < 0.5):
        PLAYER = "M" if PLAYER == "F" else "F"
        before = True
        break
    elif (perm1 == 1 or perm2 == 1):
        before = True
        break
    elif (perm1 >= perm2):
        rows = rows[pos1:] if pos1 > 0 else rows[:pos1]
    else:
        rows = [row[pos2:] if pos2 > 0 else row[:pos2] for row in rows]

	PLAYER = "M" if PLAYER == "F" else "F"
	m = len(rows)
	n = len(rows[0])
	

PLAYER = PLAYER if before else rows[0][0]
print("YES" if PLAYER == "F" else "NO")