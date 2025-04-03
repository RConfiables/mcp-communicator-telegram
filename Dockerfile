# Usa una imagen base oficial de Node.js. Ajusta la versión si es necesario (14 o superior).
FROM node:18-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo package.json y package-lock.json (si existe)
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia el resto del código fuente de la aplicación al contenedor
COPY . .

# Define las variables de entorno para los grupos y foros
# Define la variable de entorno para el token de Telegram
ENV TELEGRAM_BOT_TOKEN ""
# Grupo: SE VENDE
ENV SE_VENDE_GROUP_ID "-1002201862671"
ENV SE_VENDE_SOLARES_THREAD_ID "1188"
ENV SE_VENDE_APARTAMENTOS_THREAD_ID "776"
ENV SE_VENDE_CLUB_THREAD_ID "1183"
ENV SE_VENDE_EDIFICIOS_THREAD_ID "1184"
ENV SE_VENDE_OFICINAS_THREAD_ID "1186"
ENV SE_VENDE_FINCA_THREAD_ID "1185"
ENV SE_VENDE_LOCAL_COMERCIAL_THREAD_ID "830"
ENV SE_VENDE_SOLARES_ALT_THREAD_ID "773"
ENV SE_VENDE_PENTH_HOUSE_THREAD_ID "1187"
ENV SE_VENDE_CASAS_DE_LUJO_THREAD_ID "1180"
ENV SE_VENDE_VILLAS_THREAD_ID "774"

# Grupo: SE ALQUILA
ENV SE_ALQUILA_GROUP_ID "-1002216034625"
ENV SE_ALQUILA_APARTAMENTOS_THREAD_ID "701"
ENV SE_ALQUILA_CLUB_THREAD_ID "864"
ENV SE_ALQUILA_CASA_DE_LUJO_THREAD_ID "865"
ENV SE_ALQUILA_EDIFICIOS_THREAD_ID "866"
ENV SE_ALQUILA_FINCA_THREAD_ID "868"
ENV SE_ALQUILA_LOCAL_COMERCIAL_THREAD_ID "869"
ENV SE_ALQUILA_OFICINAS_THREAD_ID "871"
ENV SE_ALQUILA_LOCAL_COMERCIAL_ALT_THREAD_ID "870"
ENV SE_ALQUILA_TERRENOS_THREAD_ID "874"
ENV SE_ALQUILA_VILLAS_THREAD_ID "875"

# Grupo: AiRBnB
ENV AIRBNB_GROUP_ID "-1002627641191"
ENV AIRBNB_APARTAMENTOS_THREAD_ID "6"
ENV AIRBNB_CASA_DE_PLAYA_THREAD_ID "5"
ENV AIRBNB_EDIFICIOS_THREAD_ID "7"
ENV AIRBNB_FINCA_THREAD_ID "8"
ENV AIRBNB_OFICINAS_THREAD_ID "10"
ENV AIRBNB_PENT_HOUSE_THREAD_ID "9"
ENV AIRBNB_CASAS_THREAD_ID "4"
ENV AIRBNB_VILLAS_THREAD_ID "12"

# Define el comando para ejecutar la aplicación
CMD ["npm", "start"]

FROM node:18-slim
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Expone el puerto 8080 (¡obligatorio para Cloud Run!)
EXPOSE 8080

# Define las variables de entorno (opcional, pero mejor inyectarlas en Cloud Run)
ENV TELEGRAM_BOT_TOKEN=""
# ... (resto de variables)

# Inicia la aplicación usando el puerto 8080
CMD ["npm", "start"]
