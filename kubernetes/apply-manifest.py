import os 
import subprocess

base_path = '/home/ubuntu/ultimate-devops-project-micro-services-based/kubernetes'

for folder_name in os.listdir(base_path):
    folder_path = os.path.join(base_path, folder_name)
    if os.path.isdir(folder_path):
        deploy_file = os.path.join(folder_path, 'deploy.yaml')
        service_file = os.path.join(folder_path, 'svc.yaml')

        if os.path.isfile(deploy_file):
            subprocess.run(['kubectl', 'apply', '-f', deploy_file])
        
        if os.path.isfile(service_file):
            subprocess.run(['kubectl', 'apply', '-f', service_file])
