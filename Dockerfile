# Базовый образ для сборки
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Копируем csproj и восстанавливаем зависимости
COPY *.sln .
COPY YourProjectName/*.csproj ./YourProjectName/
RUN dotnet restore

# Копируем остальной код и собираем приложение
COPY YourProjectName/. ./YourProjectName/
WORKDIR /app/YourProjectName
RUN dotnet publish -c Release -o out

# Базовый образ для запуска
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/YourProjectName/out .

# Настройка порта приложения
ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

# Команда запуска
ENTRYPOINT ["dotnet", "YourProjectName.dll"]
