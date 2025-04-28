# Базовый образ для сборки
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Копируем csproj и восстанавливаем зависимости
COPY *.sln .
COPY OO/*.csproj ./OO/
RUN dotnet restore

# Копируем остальной код и собираем приложение
COPY OO/. ./OO/
WORKDIR /app/OO
RUN dotnet publish -c Release -o out

# Базовый образ для запуска
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/OO/out .

# Настройка порта приложения
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

# Команда запуска
ENTRYPOINT ["dotnet", "OO.dll"]
