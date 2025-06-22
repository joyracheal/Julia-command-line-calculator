function process_line(line)
    # Try splitting by spaces first
    tokens = split(line)
    
    # If we don't get exactly 3 tokens, try parsing without spaces
    if length(tokens) != 3
        # Attempt to parse expression without spaces using regex
        m = match(r"^(-?[\d.]+)([+\-*/])(-?[\d.]+)$", line)
        if m !== nothing
            tokens = [m[1], m[2], m[3]]
        else
            println("Error: Invalid input format. Please use: <number><operator><number> or <number> <operator> <number>")
            return
        end
    end

    # Parse numbers with proper scoping
    num1 = tryparse(Float64, tokens[1])
    num2 = tryparse(Float64, tokens[3])

    # Check if parsing succeeded
    if num1 === nothing || num2 === nothing
        println("Error: Non-numeric input detected. Please enter valid numbers.")
        return
    end

    op = tokens[2]
    if op == "+"
        println(num1 + num2)
    elseif op == "-"
        println(num1 - num2)
    elseif op == "*"
        println(num1 * num2)
    elseif op == "/"
        if num2 == 0
            println("Error: Division by zero is not allowed.")
        else
            println(num1 / num2)
        end
    else
        println("Unknown operation: $op")
    end
end

function main()
    println("Welcome to the Julia Calculator!")
    println("Enter expressions like '3 + 4' or '3+4' or type 'exit' to quit.")
    while true
        print("> ")
        line = readline(stdin)

        if line == "exit"
            println("Goodbye!")
            break
        else
            process_line(line)
        end
    end
end

main()
