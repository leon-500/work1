NGINX Ingress Controller https://kubernetes.github.io/ingress-nginx/

Ingress https://kubernetes.io/docs/concepts/services-networking/ingress/

Ingress Controllers https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/






В deployment-е

spec:
      containers:      
      - args:      
        - /nginx-ingress-controller        
        # Задаём класс,который будет обслуживать контроллер, который можно указывать в манифесте ingress, например ingress-class=my-test-ingress        
        - --ingress-class=nginx        
        # Определяет namespace который будет обслуживать контроллер. Если пустой, то отслеживаются все namespaces        
        # - --watch-namespace=my-project-namespace


      nodeSelector:
        # обязательно пометить ноды, на которых может быть установлен контроллер
        ingress-nginx-node: enable


В service ingress-nginx-controller открываем порты только на тех машинах, где находятся  поды контроллера

externalTrafficPolicy: Local
