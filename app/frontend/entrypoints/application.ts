import * as ActionCable from '@rails/actioncable';

import.meta.glob('../channels/**/*_channel.ts', { eager: true });

ActionCable.logger.enabled = true;
