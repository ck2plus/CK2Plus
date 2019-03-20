i = '#'
dynnumber = 0

with open('../../CK2Plus/common/dynasties/01_dynasties.txt', 'r') as lines:
	for line in lines.readlines():
		strippedlines = line.strip()
		if strippedlines.endswith("="):
			dynnumber = int(strippedlines[:-1])+1

dynname = []
print('Enter dynasties to append. To end, type nothing and just press enter.')
while i != '':
	i = (str(input('')))
	if i != '':
		dynname.append(str(i))
	elif i == '':
		pass
i = '#'
dynremaining = int(len(dynname)-1)

dyncultures = []
print('Enter cultures to append to. To end, type nothing and just press enter.')
while i != '':
	i = (str(input('')))
	if i != '':
		dyncultures.append(str(i))
	elif i == '':
		pass
cultremaining = int(len(dyncultures)-1)

file = open('../../CK2Plus/common/dynasties/01_dynasties.txt', 'a')
while cultremaining != -1:
	file.write(str('{}={{\n\tname="{}"\n\tculture="{}"\n}}\n'.format(dynnumber, dynname[dynremaining], dyncultures[cultremaining])))
	dynremaining = dynremaining - 1
	dynnumber = dynnumber + 1
	if dynremaining == -1:
		dynremaining = int(len(dynname)-1)
		cultremaining = cultremaining - 1
	else:
		pass
file.close()