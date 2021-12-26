local M = {}
function M.solver(coins)
	table.sort(coins, function(a, b) return a > b end)
	return function(sum)
		node = { parent = nil, val = 0, children = {} , checked = true }

		curs = 0 -- current sum
		counter = 0

		while (node ~= nil and curs < sum) do
			if (node.checked == false) then 
				curs = curs + node.val 
				counter = counter + 1
			end
			node.checked = true
			-- generating child nodes
			if (#node.children == 0) then
				for i, c in ipairs(coins) do
					if (c + curs == sum) then 
						return counter + 1
					end
					if ((c > node.val and node.val ~= 0) or c + curs > sum) then 
						-- skipping coin
					else
						node.children[#node.children + 1] = { parent = node, val = c, children = {}, checked = false }
					end
				end	
			end

			-- looking for max unchecked child
			local chosen = nil
			for i, child in ipairs(node.children) do
				if child.checked == false then
					chosen = child
					break
				end
			end
			if (chosen == nil) then
				curs = curs - node.val
				counter = counter - 1
				node = node.parent 
			else
				node = chosen
			end
		end
		return nil
	end
end
return M