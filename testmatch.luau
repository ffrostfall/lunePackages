local cases = {
	"--test",
	"--test=1",
}
local pattern = "^%-%-(%w+)=?"

for _, case in cases do
	print(string.match(case, pattern))
end
