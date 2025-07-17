import * as fs from 'fs';
import { promisify } from 'util';
import { protos, SpeechClient } from '@google-cloud/speech';

const client = new SpeechClient();

export async function transcribeAudio(filePath: string): Promise<string> {
  const readFile = promisify(fs.readFile);
  const audioBytes = (await readFile(filePath)).toString('base64');
  const request = {
    audio: {
      content: audioBytes,
    },
    config: {
      encoding: protos.google.cloud.speech.v1.RecognitionConfig.AudioEncoding.LINEAR16,
      sampleRateHertz: 48000,
      languageCode: 'en-US',
    },
  };

  const [response] = await client.recognize(request);

  const transcription = response.results
    ?.map(result => result.alternatives?.[0]?.transcript)
    .join('\n');

  return transcription || 'empty transcription';
}
