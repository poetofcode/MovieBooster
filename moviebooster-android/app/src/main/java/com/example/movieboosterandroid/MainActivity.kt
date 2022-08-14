package com.example.movieboosterandroid

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import com.example.kmmshared.Greeting
import com.example.kmmshared.domain.PostRepository
import com.example.kmmshared.domain.PostUseCase

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val greetingTextView = findViewById<TextView>(R.id.greeting_text_view)

        // Invoke shared (kmm) code
        val useCase = PostUseCase(PostRepository())
        useCase.fetchPosts { posts ->
            greetingTextView.text = posts.joinToString(separator = "\n") { it.title }
        }
    }
}