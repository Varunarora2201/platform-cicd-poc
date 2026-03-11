# Stage 1 - Build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app

COPY src/hello-world-api ./hello-world-api

WORKDIR /app/hello-world-api

RUN dotnet restore
RUN dotnet publish -c Release -o out


# Stage 2 - Runtime container
FROM mcr.microsoft.com/dotnet/aspnet:7.0

WORKDIR /app

COPY --from=build /app/hello-world-api/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "HelloWorldApi.dll"]