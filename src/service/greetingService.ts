export interface GreetingMessage {
  message: string;
}

export default {
  getGreetingMessage: (name?: string): GreetingMessage => {
    return {
      message: `Well hello, ${name || 'John Doe'}!`
    }
  }
}