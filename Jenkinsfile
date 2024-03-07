pipeline {
    agent any
    tools { 
      maven 'MAVEN_HOME' 
    }
    stages {
        stage('Build') {
            steps {
                
                // Build Spring Boot application
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                // Run tests
                sh 'mvn test'
            }
        }
        stage('Containerize with Docker') {
            steps {
                // Build Docker image
                sh 'docker build -t spring-boot-docker:spring-docker .'
            }
        }
        stage('Run Application') {
            steps {
                // Push Docker image 
                sh 'docker run -p 8080:8080 spring-boot-docker:spring-docker .'
            }
        }
        stage('Set Up Prometheus and Grafana') {
            steps {
                // Run Prometheus in Docker container
                sh 'docker run -d --name prometheus -p 9090:9090 -v $(pwd)/prometheus.yml:/Users/phozisaqwemesha/spring-boot/spring-boot-hello-world/prometheus.yml prom/prometheus'

                // Run Grafana in Docker container
                sh 'docker run -d -p 3000:3000 grafana/grafana'

                // Wait for services to start
                sleep time: 30, unit: 'SECONDS'

                // Configure Prometheus data source in Grafana
                sh 'curl -X POST -H "Content-Type: application/json" -d \'{"name":"Prometheus","type":"prometheus","url":"http://localhost:9090","access":"proxy","isDefault":true}\' http://admin:admin@localhost:3000/api/datasources'
            }
        }
        stage('Create Grafana Dashboard') {
            steps {
                // Import dashboard
                sh 'curl -X POST -H "Content-Type: application/json" -d @dashboard.json http://admin:admin@localhost:3000/api/dashboards/db'
            }
        }
    }
}
