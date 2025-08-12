using HTTP
using JSON

function ask_llm(prompt::String)
    url = "http://127.0.0.1:11434/api/chat"
    data = Dict(
        "model" => "phi3",
        "messages" => [Dict("role" => "user", "content" => prompt)],
        "stream" => false
    )
    response = HTTP.post(url, ["Content-Type" => "application/json"], JSON.json(data))
    result = JSON.parse(String(response.body))
    return result["message"]["content"]
end

println("Chat with Phi3 (type 'exit' to quit):")
while true
    print("You: ")
    user_input = readline()
    if lowercase(user_input) == "exit"
        println("Goodbye!")
        break
    end
    response = ask_llm(user_input)
    println("Phi3: ", response)
end