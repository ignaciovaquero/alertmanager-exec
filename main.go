package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodPost {
			var bytesBody bytes.Buffer
			body, _ := ioutil.ReadAll(r.Body)
			json.Indent(&bytesBody, body, "", "\t")
			fmt.Println(string(bytesBody.Bytes()))
		}
	})
	log.Fatal(http.ListenAndServe(":9090", nil))
}
