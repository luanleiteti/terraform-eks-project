import boto3
import os
import json

def get_nodegroup_sizes(eks_client, cluster_name, nodegroup_name):
    response = eks_client.describe_nodegroup(
        clusterName=cluster_name,
        nodegroupName=nodegroup_name
    )
    scaling_config = response['nodegroup']['scalingConfig']
    
    return {
        'desiredSize': scaling_config['desiredSize'],
        'minSize': scaling_config['minSize'],
        'maxSize': scaling_config['maxSize']
    }

def scale_cluster(eks_client, cluster_name, nodegroup_name, action='start'):
    current_sizes = get_nodegroup_sizes(eks_client, cluster_name, nodegroup_name)
    
    if action == 'stop':
        return {
            'desiredSize': 0,
            'minSize': 0,
            'maxSize': current_sizes['maxSize']  # Mantém o maxSize original
        }
    else:
        # Quando iniciar, usa o maxSize como desired para garantir a capacidade necessária
        return {
            'desiredSize': current_sizes['maxSize'],
            'minSize': 1,
            'maxSize': current_sizes['maxSize']
        }

def lambda_handler(event, context):
    action = event['action']  # 'start' ou 'stop'
    
    # Inicializar clientes
    eks = boto3.client('eks')
    rds = boto3.client('rds')
    
    # Configurações dos clusters
    eks_cluster_name = os.environ['EKS_CLUSTER_NAME']
    rds_instance_name = os.environ['RDS_INSTANCE_NAME']
    eks_nodegroup_name = os.environ['EKS_NODEGROUP_NAME']
    
    try:
        # Gerenciar EKS
        scaling_config = scale_cluster(eks, eks_cluster_name, eks_nodegroup_name, action)
        eks.update_nodegroup_config(
            clusterName=eks_cluster_name,
            nodegroupName=eks_nodegroup_name,
            scalingConfig=scaling_config
        )
        
        # Gerenciar RDS - Usando comandos para instância ao invés de cluster
        if action == 'stop':
            rds.stop_db_instance(DBInstanceIdentifier=rds_instance_name)
        elif action == 'start':
            rds.start_db_instance(DBInstanceIdentifier=rds_instance_name)
            
        return {
            'statusCode': 200,
            'body': f'Successfully {action}ed clusters and database'
        }
        
    except Exception as e:
        print(f"Error: {str(e)}")
        raise e 