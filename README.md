
![image](screenshots.png)  
 

### Installing (for linux)

open the terminal and follow the white rabbit.


```
https://github.com/TijsClauwers/crud-bicep.git
```
```
cd example-flask-crud/
```
```
python3 -m venv venv
```
```
source venv/bin/activate
```
```
pip install --upgrade pip
```
```
pip install -r requirements.txt
```
```
export FLASK_APP=crudapp.py
```
```
flask db init
```
```
flask db migrate -m "entries table"
```
```
flask db upgrade
```
```
flask run
```

# CRUD App on Azure using Bicep 🚀

This project is a simple Flask-based CRUD application that is containerized with Docker and deployed to Azure using **Bicep** templates. It includes:

- A dedicated Azure Virtual Network (VNet) and subnets
- An Azure Container Instance (ACI) to host the app
- An Application Gateway to expose the app on port 80
- Azure Monitor integration to collect logs
- Bicep modules for Infrastructure as Code

---

## 🌐 Live Demo

🟢 Once deployed, the app is accessible via a public IP provided by the Application Gateway.

---

## 📁 Project Structure

```plaintext
example-flask-crud/
│
├── app/                   # Flask app (routes, models)
├── modules/               # Bicep modules (network, ACI, gateway, logging)
│   ├── aci.bicep
│   ├── network.bicep
│   ├── appgw.bicep
│   └── loganalytics.bicep
├── Dockerfile             # Builds the app container
├── start.sh               # Starts the app + runs DB migrations
├── main.bicep             # Entry point Bicep deployment
├── requirements.txt       # Python dependencies
└── README.md              # You're here!
```

---

## 🚀 How to Deploy

1. Build and push your Docker image:
   ```bash
   docker build -t acrtcFINAL.azurecr.io/crud-app:v3 .
   docker push acrtcFINAL.azurecr.io/crud-app:v3
   ```

2. Deploy the infrastructure:
   ```bash
   az deployment group create `
     --resource-group <your-rg> `
     --template-file main.bicep `
     --parameters `
       imageName='acrtcFINAL.azurecr.io/crud-app:v3' `
       acrPassword=$(az acr credential show --name acrtcFINAL --query "passwords[0].value" -o tsv)
   ```

---

## 🧠 Features

✅ CRUD functionality using Flask + SQLAlchemy  
✅ Dockerized and deployable via Azure ACI  
✅ Application Gateway with public IP  
✅ Logs visible in Azure Monitor (Log Analytics)  
✅ Network isolation using custom VNet/subnets  
✅ Modular, reusable Bicep templates

---

## 🛠 Technologies Used

- Python (Flask, SQLAlchemy)
- Docker
- Azure Container Instances (ACI)
- Azure Application Gateway
- Azure Log Analytics
- Bicep (Infrastructure as Code)

---

## 📄 License

MIT or your license of choice

---

## 🙌 Author

Tijs Clauwers  

