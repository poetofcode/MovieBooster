package com.example.movieboosterandroid

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import com.example.kmmshared.data.repository.PostRepository
import com.example.kmmshared.domain.PostUseCase

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val greetingTextView = findViewById<TextView>(R.id.greeting_text_view)

        // Invoke shared (kmm) code
        val useCase = PostUseCase(PostRepository())
        useCase.fetchPosts(searchQuery = "bL") { posts ->
            greetingTextView.text = posts.joinToString(separator = "\n") { it.title }
        }
    }
}