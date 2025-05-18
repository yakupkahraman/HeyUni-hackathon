from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from openai import OpenAI
from typing import List

app = FastAPI()

# Initialize OpenAI client with your API key
client = OpenAI(api_key="no freeloaders")

# In-memory conversation store: {id: [messages]}
conversations = {}

class ChatRequest(BaseModel):
    id: str
    message: str

class ChatResponse(BaseModel):
    response: str

class User(BaseModel):
    id: str
    email: str
    password: str
    name: str
    surname: str
    country: str
    language: str
    yearsUntilGrad: str
    budget: str
    educationLanguage: str
    educationLanguageProficiency: str
    englishProficiency: str
    targetMajor: str
    interests: str

@app.post("/")
def create_user(user: User):
    print(user.model_dump())
    conversations[user.id] = []
    user_data = "Hello, I am a user, I am looking for a college that fits my needs Here is a brief description of me: "
    for user_field, user_value in user.model_dump().items():
        user_data += f"{user_field}: {user_value}, "
    user_data = user_data[:-2]  # Remove the last comma and space
    user_data += "."
    user_data += """Now ask me 5 open ended questions to get to know me better and help me find a college that fits my needs. Make it so that with every response you ask one specific question. After I answer these 3 questions, return a json file with 5 best fits for me with the following fields: "college_name", "college_location", "what_they_specialize_in", and student "fit_score" out of 100. Make sure to include the following information in the json file like the following format: {"college_name", "college_location", "what_they_specialize_in", "fit_score"} for every school all bundled together in an array. THE LAST RESPONSE SHOULD BE A PURE JSON. NO EXPLANATION, JUST DATA!"""
    print(user_data)
    if user.id not in conversations:
        conversations[user.id] = []
    conversations[user.id].append({"role": "user", "content": user_data})
    return {"message": "User created", "user": user.model_dump()}

@app.post("/chat", response_model=ChatResponse)
async def chat(req: ChatRequest):
    print(req.model_dump())
    if not req.message.strip():
        raise HTTPException(status_code=400, detail="Message cannot be empty.")

    if req.id not in conversations:
        conversations[req.id] = []

    # Add user message to conversation history
    conversations[req.id].append({"role": "user", "content": req.message})

    try:
        response = client.chat.completions.create(
            model="gpt-4.1",  # Replace with actual GPT-4.1 model name if different
            messages=conversations[req.id],
            max_tokens=500,
            temperature=0.7,
        )

        assistant_message = response.choices[0].message.content

        # Append assistant's reply to conversation
        conversations[req.id].append({"role": "assistant", "content": assistant_message})

        return ChatResponse(response=assistant_message)

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"OpenAI API error: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
