# Usa la imagen oficial de Node.js 18
FROM node:18-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY package*.json ./

# Instala todas las dependencias (incluyendo devDependencies)
RUN npm install --include=dev

# Copia todo el código fuente
COPY . .

# Compila TypeScript a JavaScript
RUN npm run build

# Expone el puerto requerido por Cloud Run
EXPOSE 8080

# Comando de inicio (usa el script definido en package.json)
CMD ["npm", "start"]
