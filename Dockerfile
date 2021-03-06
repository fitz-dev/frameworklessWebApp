FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# copy the files from the application folder and then copy over to new file structure or existing file structure i.e /Program/ if wanted a sub folder called Program
COPY /WebApplication/*.csproj ./WebApplication/
RUN dotnet restore ./WebApplication/

COPY /WebApplicationTests/*.csproj ./WebApplicationTests/
RUN dotnet restore ./WebApplicationTests/

# Copy everything else and build upon the base image from build-env
COPY . ./
RUN dotnet build 
RUN dotnet test 

FROM build-env AS publish 
WORKDIR /app
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "WebApplication.dll"]

