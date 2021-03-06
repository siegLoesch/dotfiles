--+-----------------------------------------------------------------------------
--|
--| @file:                  nvimTemplates/insertFileHeader/init.lua
--| @brief:                 Inserts/updates file header
--| @details:               Inserts/updates file header dependent on filetype
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 16:54:38
--| @date: Last updated at: 2020-11-22 16:54:38
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------

local M = {}

M.shebangLine = nil	-- Gloabal variable "shebangLine" indicates if it is present
M.logfile = "template.log"

local function printd (stringToPrint)
	local logfh = io.open( M.logfile, "w" )
	logfh:write(stringToPrint.."\n")
	logfh:close()
end

local currentDate = os.date("%Y-%m-%d %H:%M:%S")

local function setLineHeaders ( currentFiletype )
	local lineHeaders = {}
	if currentFiletype == "cmake" or currentFiletype == "text" or currentFiletype == "sh" then
		-- printd("setLineHeaders: fileType: cmake or txt")
		lineHeaders[1] = string.format("%-25s", " File: ") -- fileName
		lineHeaders[2] = string.format("%-25s", " Brief: ") -- fileDesc
		lineHeaders[3] = string.format("%-25s", " Details: ") -- fileDetailDesc
		lineHeaders[4] = string.format("%-25s", " Author: ") -- author
		lineHeaders[5] = string.format("%-25s", " Created at: ") -- createTime
		lineHeaders[6] = string.format("%-25s", " Last updated at: ") -- lastUpdate
		lineHeaders[7] = string.format("%-25s", " Version: ") -- version
		lineHeaders[8] = string.format("%-25s", " Copyright: ") -- license
	elseif currentFiletype == "lua" or currentFiletype == "vim" or currentFiletype == "cpp" then
		-- printd("setLineHeaders: fileType: lua or vim or cpp")
		lineHeaders[1] = string.format("%-25s", " @file: ") -- fileName
		lineHeaders[2] = string.format("%-25s", " @brief: ") -- fileDesc
		lineHeaders[3] = string.format("%-25s", " @details: ") -- fileDetailDesc
		lineHeaders[4] = string.format("%-25s", " @author: ") -- author
		lineHeaders[5] = string.format("%-25s", " @date: Created at: ") -- createTime
		lineHeaders[6] = string.format("%-25s", " @date: Last updated at: ") -- lastUpdate
		lineHeaders[7] = string.format("%-25s", " @version: ") -- version
		lineHeaders[8] = string.format("%-25s", " @copyright: ") -- license
	else
		print("Prefix for current filetype <"..currentFiletype.."> not defined!")
		print("Please define.")
	end
	return lineHeaders
end

local function setLinePrefix (curBuf, currentFiletype)   -- Set box comment prefix
	-- Get the filetype
	local linePrefix = nil
	if currentFiletype == "cmake" then
		linePrefix = "#"
	elseif currentFiletype == "text" then
		linePrefix = "#"
	elseif currentFiletype == "sh" then
		-- Check for shebang line
		local lineA = vim.api.nvim_buf_get_lines(curBuf, 0, 1, true)
		if string.find(lineA[1], "#!") then
			M.shebangLine = true
		end
		linePrefix = "#"
	elseif currentFiletype == "lua" then
		linePrefix = "--"
	elseif currentFiletype == "vim" then
		linePrefix = "\""
	elseif currentFiletype == "cpp" then
		linePrefix = "//"
	else
		error("Prefix for current filetype <"..currentFiletype.."> not defined!")
	end
	print("currentFiletype: <"..currentFiletype..">")
	return linePrefix
end

local function setHeaderLines( linePrefix, currentFiletype ) -- Prepare box
	local _fileName = vim.api.nvim_buf_get_name(0)
	local _fileDesc = "Brief file description"
	local _fileDetailDesc = "Detailed file description"
	local _author = os.getenv("Full_Name")
	if not _author then
		print("Set environment varaible 'Full_Name' to authors name!")
		print("Using default authors name for now: 'Firstname Lastname'")
		_author = "Firstname Lastname"
	end
	local _version = "1.0.0"
	local _license1 = "Distributed under the MIT License"
	local _license2 = string.rep(" ",25).."See: http://opensource.org/licenses/MIT"
	local tmpStringA = linePrefix.."+"
	local tmpStringB = string.rep("-", 80-#linePrefix-1)
	local lineHeaders = setLineHeaders( currentFiletype)
	local headerLines = {}
	headerLines[1] = tmpStringA..tmpStringB
	headerLines[2] = linePrefix.."|"
	tmpStringA = linePrefix.."|"
	local extension = string.match(_fileName,"([^/]-([^.]+))$")
	headerLines[3] = tmpStringA..lineHeaders[1]..extension
	headerLines[4] = tmpStringA..lineHeaders[2].._fileDesc
	headerLines[5] = tmpStringA..lineHeaders[3].._fileDetailDesc
	headerLines[6] = tmpStringA..lineHeaders[4].._author
	headerLines[7] = tmpStringA..lineHeaders[5]..currentDate
	headerLines[8] = tmpStringA..lineHeaders[6]..currentDate
	headerLines[9] = tmpStringA..lineHeaders[7].._version
	headerLines[10] = tmpStringA..lineHeaders[8].._license1
	headerLines[11] = tmpStringA.._license2
	headerLines[12] = headerLines[2]
	headerLines[13] = headerLines[1]
	return headerLines
end

local function updateLastTime(curBuf,currentFiletype)
	-- Regenerate text of update line
	local updateDate = os.date("%Y-%m-%d %H:%M:%S")
	local linePrefix = setLinePrefix(curBuf,currentFiletype)
	local stringFound
	local lCount = vim.api.nvim_buf_line_count(curBuf)
	local lineArray = vim.api.nvim_buf_get_lines(curBuf, 0, lCount, true)
	for lNumber = 2, lCount, 1 do
		stringFound = string.find(lineArray[lNumber], "Last updated at:")
		if stringFound ~= nil then
			vim.api.nvim_buf_set_lines(curBuf, lNumber-1, lNumber, false,
				{linePrefix.."|"..string.format("%-25s", " Last updated at: ")..updateDate})
			break
		end
	end
end

-- Gloabal functions

function M.insertHeaderLines()
	-- Holds nvim filetype value (e.g.: cpp, sh, ... )
	local curBuf = vim.api.nvim_get_current_buf()
	local currentFiletype = vim.api.nvim_buf_get_option(curBuf, "ft")
	local linePrefix = setLinePrefix( curBuf, currentFiletype )
	local headerLines = setHeaderLines( linePrefix, currentFiletype )
	-- Check for shebang line (must always be on the first line)
	if (currentFiletype == "sh") then
		if M.shebangLine then
			vim.api.nvim_buf_set_lines( 0, 1, 1, false, headerLines )
		else
			vim.api.nvim_buf_set_lines( 0, 0, 0, false, {"#!/bin/bash"})
			vim.api.nvim_buf_set_lines( 0, 1, 1, false, headerLines )
		end
	else
		vim.api.nvim_buf_set_lines( 0, 0, 0, false, headerLines )
	end
end

function M.updateTime()
	local curBuf = vim.api.nvim_get_current_buf()
	local currentFiletype = vim.api.nvim_buf_get_option(curBuf, "ft")
	updateLastTime(curBuf,currentFiletype)
end

return M
