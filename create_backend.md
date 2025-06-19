# create backend state on azure blob storage account

### Create Variables
```
COMPANY='matactl'
PROJECT='apim'
LOCATION='southeastasia'
TF_RESOURCE_GROUP="rg-${COMPANY}-${PROJECT}-tfstate"
TF_STORAGE_ACCOUNT="sa${COMPANY}${PROJECT}tfstate"
OWNER='morakot.i@kaopanwa.co.th'
ENVIRONMENT='poc'
TAGS="owner=${OWNER} environment=${ENVIRONMENT} company=${COMPANY} project=${PROJECT}"
```

### Create Resources
```
az group create --name ${TF_RESOURCE_GROUP}  \
--location ${LOCATION} \
--tags ${TAGS} 

az storage account create --name ${TF_STORAGE_ACCOUNT} \
--resource-group ${TF_RESOURCE_GROUP} \
--location ${LOCATION} \
--sku Standard_LRS \
--kind StorageV2 \
--tags ${TAGS}
```

### Export parameter
```
echo "export backend_resource_group=$TF_RESOURCE_GROUP"
echo "export backend_storage_name=$TF_STORAGE_ACCOUNT"
```