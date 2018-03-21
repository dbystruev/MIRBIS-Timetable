import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
        
        get("index") { req in
            let path = self.config.publicDir + "index.html"
            let res = try Response(filePath: path)
            return res
        }
        
        get("publicDir") { req in
            return self.config.publicDir
        }
        
        get("/") { req in
            return Response(redirect: "info")
        }
    }
}
