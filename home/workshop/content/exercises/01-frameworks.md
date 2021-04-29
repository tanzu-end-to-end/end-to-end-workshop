You want your developers to create resilient applications that are easy to operate and can scale to meet demand. We're going to start our story with Cody. He's not a deep expert on container infrastructure, but he's an absolute star in writing business applications using popular languages and frameworks.

![Cody Languages](images/cody-languages.png)

Tanzu supports developers as they are creating   or modernizing applications.  VMware is the company behind the most popular Java development framework in the world, [Spring Boot](https://spring.io/).  Spring Boot is popular because it provides developers everything they need to create microservices that power some of the world's most heavily used applications such as Netflix.  It provides modern, reactive services for high performance applications, robust and simplified access to supporting application services like relational databases, messaging services like Kafka, and built-in observability and manageability features that make those applications much easier for operators to run.

Cody has chosen to write his new web app in Spring Boot, and he knows the best place to start is https://start.spring.io.

```dashboard:create-dashboard
name: Spring
url: https://start.spring.io/
```

From this interface, developers can quickly find the services they need to start their projects using the latest frameworks employing the most modern best practices for cloud native applications.

> Add dependencies for Actuator, Kafka, and Reactive Web, then click the "Explore" button to show the project that would be generated.  This accelerates developer productivity!

VMware also invests in the popular [Steeltoe](https://steeltoe.io) project which provides a similar experience for .NET developers

```dashboard:create-dashboard
name: Steeltoe
url: https://start.steeltoe.io/
```

And developers don't have to learn all of these cloud-native practices themselves!  Tanzu's "Pivotal Labs" team has decades of experience helping organizations rapidly deliver outcomes that matter to your business.  They have entire practices geared towards delivering net-new applications, as well as an extensive practice to help large organizations understand and modernize their existing applications to take the best advantage of cloud application benefits.

So now that we have an application, let's explore how Tanzu supports delivering that application as a container.