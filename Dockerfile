# Imagem base oficial do Python
FROM python:3.10-slim

# Criar diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements e instalar pacotes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo o código para dentro do container
COPY . .

# Expor porta padrão do Django/Gunicorn
EXPOSE 8000

# Rodar Gunicorn apontando para o módulo correto
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
