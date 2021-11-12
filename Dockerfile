FROM mcr.microsoft.com/dotnet/core/aspnet:2.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
WORKDIR /tmp/app

COPY . .
RUN ls -la
RUN dotnet restore
RUN ls -la

RUN dotnet publish -c Release -o out
RUN ls -la

FROM base
WORKDIR /app
COPY --from=build /tmp/app/out .
RUN ls -la
ENTRYPOINT ["dotnet", "dotnet-core-hello-world.dll"]
