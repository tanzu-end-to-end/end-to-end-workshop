For this workshop, we'll be using the cannonical Spring PetClinic example application.  Fork the repository to your Github account so we can add a few things to it.

```dashboard:create-dashboard
name: Github
https://github.com/spring-projects/spring-petclinic/fork
```

Now that you have forked the repo, we need to apply a few changes to it.  These changes enable metrics to flow into Tanzu Obverability from the application.  Using the Github Web UI, edit the pom.xml in the root of the project.  Search the file for the top-level `</properties>` closing tag, and insert the following line just above it.

```copy
<wavefront.version>2.0.1</wavefront.version>
```

Next, just under the `</properties>` closing tag, add the following block.

```copy
  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.wavefront</groupId>
        <artifactId>wavefront-spring-boot-bom</artifactId>
        <version>${wavefront.version}</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
      <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-dependencies</artifactId>
        <version>Hoxton.SR8</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
  </dependencyManagement>
```

Search for the `<dependencies>` starting tag.  Insert the following just below that opening tag.

```copy
    <dependency>
      <groupId>com.wavefront</groupId>
      <artifactId>wavefront-spring-boot-starter</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-sleuth</artifactId>
    </dependency>
```

Commit your change.

Next, we want to prevent data from being sent to Tanzu Observability while builds or tests are run.  Edit the ` `, look for the `@SpringBootTest` annotation, and paste the following text just above it.

```copy
import org.springframework.test.context.ActiveProfiles;

@ActiveProfiles("test")
```

Commit your change.

Finally, add a new folder under `src/test` called `resources`.  In the new folder you created, add a new file called `application-test.properties` add the following text.

```copy
management.metrics.export.wavefront.enabled=false
management.metrics.export.wavefront.apiToken=foo
```

Commit this final change.