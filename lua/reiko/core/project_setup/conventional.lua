local function run_python()
  local file_path = vim.fn.expand("%")
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.4 python "..file_path)
end

local function compile_cpp()
  local file_path = vim.fn.expand("%")
  local file_name = vim.fn.expand("%:r")
  local command = string.format("g++ *.cpp -o %s.exe", file_name)
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.4 ".. command)
end

local function run_cpp()
  -- local file_path = vim.fn.expand("%")
  local file_name = vim.fn.expand("%:r")
  local command1 = string.format("g++ *.cpp -o %s.exe", file_name)
  local command2 = file_name..'.exe'
  local full_cmd = command1.."&"..command2
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.5 "..full_cmd)
end

local function compile_c()
  local file_path = vim.fn.expand("%")
  local file_name = vim.fn.expand("%:r")
  local command = string.format("gcc *.c -o %s.exe", file_name)
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.4 ".. command)
end

local function run_c()
  -- local file_path = vim.fn.expand("%")
  local file_name = vim.fn.expand("%:r")
  local command1 = string.format("gcc *.c -o %s.exe", file_name)
  local command2 = file_name..'.exe'
  local full_cmd = command1.."&"..command2
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.4 "..full_cmd)
end

local function run_asm()
  local file_name = vim.fn.expand("%:r")      -- file name without extension
  local file_path = vim.fn.expand("%")        -- full file name with extension
  local command = string.format("java -jar Mars4_5.jar %s", file_path)
  vim.cmd("w | FloatermNew --position=topright --autoclose=0 --width=0.3 --height=0.4 "..command)
end

return {
  compile_cpp = compile_cpp,
  run_cpp = run_cpp,
  compile_c = compile_c,
  run_c = run_c,
  run_python = run_python,
  run_asm = run_asm,
}
