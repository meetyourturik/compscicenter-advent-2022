strin = "abc"
nums = [ord(c) - 96 for c in strin]

# commands:
push = "push" # pushes size of a block into steck (in this case always 1)
add = "add" # removes two top elements from the stack, pushes their sum on top
mul = "mul" # removes two top elements from the stack, pushes their product on top
dup = "dup" # pushes on top of the stack same value that is currently on top
out = "out" # removes and 'prints' current top

def f(n):
	if n == 1:
		return [push]
	elif n % 2 == 0:
		return f(n / 2) + [dup, add]
	else:
		return f(n - 1) + [push, add]

commands = []
for n in nums:
	commands += f(n) + [out]

o = "_"
b = "B"
piet = [[b, add, o, o, dup, o], [push, o, o, o, o, out], [o, mul, o, o, o, o]]

def rotateSub(sub, n):
	for i in range(n):
		sub.insert(0, sub.pop(len(sub) - 1))

def rotate(li, nv, nh):
	nv = (nv + 3) % 3
	nh = (nh + 6) % 6
	for i in range(nv):
		li.insert(0, li.pop(len(li) - 1))
	li = [rotateSub(sub, nh) for sub in li]

def pos(com):
	pv = [i for i, sub in enumerate(piet) if sub.count(com) > 0][0]
	ph = piet[pv].index(com)
	return [pv, ph]

rotate(piet, 1, 0) # set up starting color as nr

colors = ["r", "y", "g", "c", "b", "m"]
shades = ["l", "n", "d"]

bnv, bnh = pos(b) 

res = [shades[bnv] + colors[bnh]]

for com in commands:
	bnv, bnh = pos(b) 
	cnv, cnh = pos(com)
	res.append(shades[cnv] + colors[cnh])
	rotate(piet, cnv - bnv, cnh - bnh)

print(len(res))
print(" ".join(res))
