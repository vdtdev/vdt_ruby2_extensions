class Hash
    def hmap
        # copy original hash; will store results here
        result = self.dup
        # pass keys and values to yield method, store result
        self.keys.each do |key|
            new_value = yield(key, self[key])
            result[key] = new_value
        end
        # return updated hash
        return result
    end
end