const TelegramBot = require('node-telegram-bot-api');
const express = require('express'); // <-- Añadir Express
require('dotenv').config();

// ================== Configurar servidor web (obligatorio para Cloud Run) ==================
const app = express();
const port = process.env.PORT || 8080; // <-- Usar puerto 8080

// Ruta básica de verificación
app.get('/', (req, res) => {
  res.status(200).send('Servidor MCP Telegram activo');
});

// Iniciar servidor
app.listen(port, () => {
  console.log(`Servidor escuchando en puerto ${port}`);
});

// ================== Lógica del Bot de Telegram ==================
const token = process.env.TELEGRAM_TOKEN;

if (!token) {
  console.error('TELEGRAM_TOKEN es requerido en variables de entorno');
  process.exit(1);
}

const bot = new TelegramBot(token, { polling: true });

console.log('Bot iniciado. Envía un mensaje a tu bot...');

bot.on('message', (msg) => {
  console.log(`Chat ID obtenido: ${msg.chat.id}`); // <-- Corregir template string
  console.log('Actualiza tus variables de entorno con este ID');
});

bot.on('error', (error) => {
  console.error('Error del bot:', error);
});

// Manejar cierre limpio
process.on('SIGINT', () => {
  console.log('Deteniendo bot...');
  bot.stopPolling();
  process.exit(0);
});
