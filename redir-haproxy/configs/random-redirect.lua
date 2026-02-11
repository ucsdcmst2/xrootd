   core.register_action("random_redirect", { "http-req" }, function(txn)
        local be_name = txn:get_var("req.backend_name")
        local backend = core.backends[be_name]

        if not backend then
            txn:Info("Backend " .. be_name .. " not found!")
            return
        end

        local alive = {}

        for name, srv in pairs(backend.servers) do
            local stats = srv:get_stats()
            local addr = srv.get_name and srv:get_name() or nil
            txn:Debug(string.format("Lua sees server: %s, status: %s", tostring(addr), tostring(stats.status)))
            if stats.status == "UP" then
                table.insert(alive, addr)
            end
        end

        if #alive > 0 then
            local pick = alive[math.random(#alive)]
            txn:set_var("req.target_host", pick)
            txn:Debug("Redirecting to " .. pick)

            -- Parse Authorization header
            local auth_header = txn.http:req_get_headers()["authorization"]
            if auth_header and auth_header[0] then
                local auth_value = auth_header[0]
                -- Extract Bearer token
                local token = auth_value:match("^Bearer%s+(.+)$")
                if token then
                    -- Encode token
                    local encoded_token = string.gsub(token, "([^%w%-%.%_%~])", function(c)
                        return string.format("%%%02X", string.byte(c))
                    end)
                    txn:set_var("req.auth_token", encoded_token)
                end
            end
        else
            txn:Info("No backend servers are UP for backend " .. be_name)
        end
    end)
