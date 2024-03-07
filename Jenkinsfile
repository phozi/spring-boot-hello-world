pipeline {
    agent any
    
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
                sh 'docker build -t spring-boot-app .'
            }
        }
        stage('Push to Registry') {
            steps {
                // Push Docker image 
                sh 'docker tag spring-boot-app phozisaq/spring-boot-app'
                sh 'docker push phozisaq/spring-boot-app'
            }
        }
        stage('Set Up Prometheus and Grafana') {
            steps {
                // Run Prometheus in Docker container
                sh 'docker run -d -p 9090:9090 -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus'

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
