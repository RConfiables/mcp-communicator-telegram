# MCP Communicator (Telegram)
Un servidor MCP que permite la comunicación con los usuarios a través de Telegram. Este servidor proporciona herramientas para interactuar con los usuarios mediante un bot de Telegram, incluyendo la posibilidad de hacer preguntas, enviar notificaciones, compartir archivos y crear archivos de proyectos.

## Installation

### Via npm (global)

```bash
npm install -g mcp-communicator-telegram
```

### Via npx (on-demand)

```bash
npx mcptelegram
```

To get your Telegram chat ID:
```bash
npx mcptelegram-chatid
```

## Features

- Hacer preguntas a los usuarios a través de Telegram
- Enviar notificaciones a los usuarios (sin necesidad de respuesta)
- Enviar archivos a los usuarios a través de Telegram
- Crear y enviar archivos zip del proyecto (respetando .gitignore)
- Recibir respuestas de forma asíncrona (espera indefinida)
- Soporte para el seguimiento de mensajes basado en respuestas
- Validación segura del ID del chat
- Gestión y registro de errores

## Prerequisites

- Node.js (v14 o superior)
- Un token de bot de Telegram (obtenido de [@BotFather](https://t.me/botfather))
- Tu ID de chat de Telegram (puedes obtenerlo con la utilidad incluida)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/qpd-v/mcp-communicator-telegram.git
cd mcp-communicator-telegram
```

2. Install dependencies:
```bash
npm install
```

3. Crea un bot en Telegram:
   - Abre Telegram y busca [@BotFather](https://t.me/botfather)
   - Envía `/newbot` y sigue las instrucciones
   - Guarda el token del bot que recibas

4. Get your chat ID:
   - Copia `.env.example` a `.env`
   - Agrega el token de tu bot al archivo `.env`:
   ```
   TELEGRAM_TOKEN=your_bot_token_here
   ```
   - Ejecuta la utilidad de ID de chat:
   ```bash
   npm run build
   node build/get-chat-id.js
   ```
   - Envía cualquier mensaje a tu bot
   - Copia el ID de chat que aparece en la consola
   - Agrega el ID de chat a tu archivo `.env`:
   ```
   TELEGRAM_TOKEN=your_bot_token_here
   CHAT_ID=your_chat_id_here
   ```

## Configuration

Add the server to your MCP settings file (usually located at `%APPDATA%\Code\User\globalStorage\rooveterinaryinc.roo-cline\settings\cline_mcp_settings.json` on Windows):

```json
{
  "mcpServers": {
    "mcp-communicator-telegram": {
      "command": "node",
      "args": ["path/to/mcp-communicator-telegram/build/index.js"],
      "env": {
        "TELEGRAM_TOKEN": "your_bot_token_here",
        "CHAT_ID": "your_chat_id_here"
      }
    }
  }
}
```

## Available Tools

### ask_user

Asks a question to the user via Telegram and waits for their response.

Input Schema:
```json
{
  "type": "object",
  "properties": {
    "question": {
      "type": "string",
      "description": "The question to ask the user"
    }
  },
  "required": ["question"]
}
```

Example usage:
```typescript
const response = await use_mcp_tool({
  server_name: "mcp-communicator-telegram",
  tool_name: "ask_user",
  arguments: {
    question: "What is your favorite color?"
  }
});
```

### notify_user

Sends a notification message to the user via Telegram (no response required).

Input Schema:
```json
{
  "type": "object",
  "properties": {
    "message": {
      "type": "string",
      "description": "The message to send to the user"
    }
  },
  "required": ["message"]
}
```

Example usage:
```typescript
await use_mcp_tool({
  server_name: "mcp-communicator-telegram",
  tool_name: "notify_user",
  arguments: {
    message: "Task completed successfully!"
  }
});
```

### send_file

Sends a file to the user via Telegram.

Input Schema:
```json
{
  "type": "object",
  "properties": {
    "filePath": {
      "type": "string",
      "description": "The path to the file to send"
    }
  },
  "required": ["filePath"]
}
```

Example usage:
```typescript
await use_mcp_tool({
  server_name: "mcp-communicator-telegram",
  tool_name: "send_file",
  arguments: {
    filePath: "path/to/file.txt"
  }
});
```

### zip_project

Creates a zip file of a project directory (respecting .gitignore patterns) and sends it to the user via Telegram.

Input Schema:
```json
{
  "type": "object",
  "properties": {
    "directory": {
      "type": "string",
      "description": "Directory to zip (defaults to current working directory)"
    }
  },
  "required": []
}
```

Example usage with default directory (current working directory):
```typescript
await use_mcp_tool({
  server_name: "mcp-communicator-telegram",
  tool_name: "zip_project",
  arguments: {}
});
```

Example usage with specific directory:
```typescript
await use_mcp_tool({
  server_name: "mcp-communicator-telegram",
  tool_name: "zip_project",
  arguments: {
    directory: "/path/to/your/project"
  }
});
```

Features:
- Creates a zip file named `[project-name]-project.zip` based on the directory name
- Can zip any specified directory or the current working directory
- Respects .gitignore patterns
- Maintains correct file paths in the archive
- Automatically cleans up the zip file after sending
- Handles files up to 2GB in size

## Development

Build the project:
```bash
npm run build
```

Run in development mode:
```bash
npm run dev
```

Watch for changes:
```bash
npm run watch
```

Clean build directory:
```bash
npm run clean
```

## Security

- The server only responds to messages from the configured chat ID
- Environment variables are used for sensitive configuration
- Message IDs are used to track question/answer pairs
- The bot ignores messages without proper context

## License

ISC

## Author

qpd-v

## Version

0.2.1  # Major version bump for new features: notify_user, send_file, and zip_project tools
