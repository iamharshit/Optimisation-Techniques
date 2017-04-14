
function input(promt)
	print(promt)
	return readline(STDIN)
end

function solution(A,B)
	inv(transpose(A)*A) * transpose(A) * B 
end

function construct_Bmatrix(eq_list)
	temp = Int64[]
	for i in 1:size(eq_list)[1]
		val = BigInt(split(eq_list[i], "=")[2])
		push!(temp,val)
	end
	return temp
end

function construct_Amatrix(eq_list, vars)
	coeff_matrix = Int64[]
	for i in 1:BigInt(vars)
		var = "x$(i)"
		coeffs = Int64[]
			for j in 1:size(eq_list)[1]
				r = match(r"[/-]*[\d]+$", split(eq_list[j],var)[1] )
				coeff = BigInt(r.match)
				push!(coeffs, coeff)
			end
		if(size(coeff_matrix)[1]==0)
			coeff_matrix = coeffs
		else
			coeff_matrix = hcat(coeff_matrix, coeffs)
		end
	end
	return coeff_matrix
end

vars = input("Enter Total Variables: ")
eqs = input("Enter Total Equations: ")

eq_list = String[]
for i in 1:BigInt(eqs)
	push!(eq_list, input("Enter Eq$(i): "))
end

A = construct_Amatrix(eq_list, vars)
B = construct_Bmatrix(eq_list)

sol = solution(A,B)
println("Best Solution is obtained at:")
for i in 1:size(sol)[1]
	println("x$(i) = $(sol[i])")
end
