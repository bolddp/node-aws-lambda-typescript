import { assert } from 'chai';
import greetingService from '../../src/service/greetingService';

describe('GreetingService', () => {
  it('should get greeting message', () => {
    const msg = greetingService.getGreetingMessage('Teste');
    assert.equal(msg.message, 'Well hello, Teste!');
  });
});