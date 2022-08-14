package com.example.kmmshared

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}