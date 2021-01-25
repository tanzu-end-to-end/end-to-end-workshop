You want your developers to create resilient applications that are easy to operate and can scale to meet demand.  [12 Factor App](https://12factor.net/) design principles, Kubernetes and other modern application development practices are still new to many developers.

Tanzu provides benefits directly to developers as they are developing or modernizing applications.  VMware is the company behind the most popular Java development framework in the world, [Spring Boot](https://spring.io/).  Spring Boot is popular because it provides developers everything they need to create microservices that power some of the world's most heavily used applications such as Netflix.  It provides modern, reactive services for high performance applications, robust and simplified access to supporting application services like relational databases, messaging services like Kafka, and built in observability and managibility features that make those applications much easier for operators to run.

And for new applications, or for modernizing existing applications with Spring Boot, the best place to start is https://start.spring.io.

```dashboard:create-dashboard
name: Spring Initializr
url: https://start.spring.io/
```

From this interface, developers can quickly find the services they need to start their projects using the latest frameworks employing the most modern best practices for cloud native applications.

> Add dependencies for Actuator, Kafka, and Reactive Web, then click the "Explore" button to show the project that would be generated.  This accelerates developer productivity!

VMware also invests in the popular [Steeltoe](https://steeltoe.io) project which provides a similar experience for .NET developers

```dashboard:create-dashboard
name: Steeltoe Initializr
url: https://start.steeltoe.io/
```

And developers don't have to learn all of these new practices by themselves!  Tanzu's "Pivotal Labs" team has decades of experience helping organizations rapidly deliver outcomes that matter to your business.  They have entire practices geared towards delivering net-new applications, as well as an extensive practice to help large organizations understand and modernize their existing applications to take the best advantage of cloud application benefits.

So now that we have an application, let's explore how Tanzu supports delivering that application as a container.