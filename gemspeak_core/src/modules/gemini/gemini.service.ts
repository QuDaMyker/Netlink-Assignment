/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { Injectable } from '@nestjs/common';
import axios from 'axios';
import * as dotenv from 'dotenv';

dotenv.config();

@Injectable()
export class GeminiService {
  private readonly GEMINI_API_KEY = process.env.GEMINI_API_KEY;
  private readonly GEMINI_API_URL =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  async sendPrompt(userText: string, question: string) {
    const prompt = `
You're an English speaking coach. A student said: "${userText}" ${question != null && question.trim() !== '' ? `to an English question: "${question}".` : ''}

Please:
1. Identify grammar mistakes and fix them.
2. Give a grammar and vocabulary score from 1 to 10.
3. Suggest improvements.
4. Return the fixed sentence.
5. Translate feedback into English.
`;

    const body = {
      contents: [{ parts: [{ text: prompt }] }],
    };

    const response = await axios.post(
      `${this.GEMINI_API_URL}?key=${this.GEMINI_API_KEY}`,
      body,
      { headers: { 'Content-Type': 'application/json' } },
    );
    const res = response.data['candidates'][0]['content']['parts'][0]['text'];
    return res;
  }
}
